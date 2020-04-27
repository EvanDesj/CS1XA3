from django.http import HttpResponse,HttpResponseNotFound
from django.shortcuts import render,redirect,get_object_or_404
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages

from . import models

def messages_view(request):
    """Private Page Only an Authorized User Can View, renders messages page
       Displays all posts and friends, also allows user to make new posts and like posts
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render private.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        if 'post_amount' not in request.session:
            request.session['post_amount'] = 1
        post_amount = request.session['post_amount']

        # COMPLETE Objective 9: query for posts (HINT only return posts needed to be displayed)
        posts = list(models.Post.objects.order_by('-timestamp'))
        posts = posts[:post_amount]
        for post in posts:
            if user_info in post.likes.all():
                post.liked = True
            else:
                post.liked = False
        # COMPLETE Objective 10: check if user has like post, attach as a new attribute to each post

        context = { 'user_info' : user_info
                  , 'posts' : posts }
        return render(request,'messages.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def account_view(request):
    """Private Page Only an Authorized User Can View, allows user to update
       their account information (i.e UserInfo fields), including changing
       their password
    Parameters
    ---------
      request: (HttpRequest) should be either a GET or POST
    Returns
    --------
      out: (HttpResponse)
                 GET - if user is authenticated, will render account.djhtml
                 POST - handle form submissions for changing password, or User Info
                        (if handled in this view)
    """
    if request.user.is_authenticated:
        password_change = False
        valid_date = True
        valid_interest = True
        valid_employment = True
        valid_location = True
        user_info = models.UserInfo.objects.get(user=request.user)
        if request.method == 'POST':
            form = PasswordChangeForm(request.user, request.POST)
            changetype = request.POST["formtype"]
            if form.is_valid(): 
                user = form.save()
                password_change = True
                update_session_auth_hash(request, user)
                return redirect('social:account_view')
            elif changetype == "employment":
                new_employment = request.POST["employment_change"]
                if new_employment is not "":
                    user_info.employment = request.POST["employment_change"]
                else:
                    valid_employment = False
            elif changetype == "location":
                new_location = request.POST["location_change"]
                if new_location is not "":
                    user_info.location = request.POST["location_change"]
                else:
                    valid_location = False
            elif changetype == "birthday":
                if request.POST["birthday_change"] == "":
                    valid_date = False
                else:
                    user_info.birthday = request.POST["birthday_change"]
            elif changetype == "interest":
                interest = request.POST["interest_add"]
                if interest is not "":
                    try:
                        get_interest = models.Interest.objects.get(label=interest)
                        if get_interest not in user_info.interests.all():
                            user_info.interests.add(get_interest)
                        else:
                            valid_interest = False
                    except:
                        create_interest = models.Interest.objects.create(label=interest)
                        user_info.interests.add(create_interest)
                else:
                    valid_interest = False
            user_info.save()
        else:
            form = PasswordChangeForm(request.user)
        context = { 'user_info' : user_info,
                    'passchange_form' : form,
                    'valid_date' : valid_date,
                    'valid_interest' : valid_interest,
                    'valid_employment' : valid_employment,
                    'valid_location' : valid_location}
        return render(request,'account.djhtml',context)
    else:
        request.session['failed'] = True
        return redirect('login:login_view')

def incShowAmount(request):
    request.session['show_people'] += 1

def people_view(request):
    """Private Page Only an Authorized User Can View, renders people page
       Displays all users who are not friends of the current user and friend requests
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render people.djhtml
    """
    if request.user.is_authenticated:
        if 'show_people' not in request.session:
            request.session['show_people'] = 1
        show_people = request.session['show_people']
        user_info = models.UserInfo.objects.get(user=request.user)
        # COMPLETE Objective 4: create a list of all users who aren't friends to the current user (and limit size)
        
        not_friends = []
        exclude_user = list(models.UserInfo.objects.exclude(user=user_info.user))
        for user in exclude_user:
            if user_info not in user.friends.all():
                not_friends.append(user)
        not_friends = not_friends[:show_people]

        # COMPLETE Objective 5: create a list of all friend requests to current user
        received_fr_query = models.FriendRequest.objects.filter(to_user=user_info)
        sent_fr_query = models.FriendRequest.objects.filter(from_user=user_info)
        received_from = []
        sent_to = []
        for r_request in received_fr_query:
            received_from.append(r_request.from_user)
        for s_request in sent_fr_query:
            sent_to.append(s_request.to_user)
        print("sent to: ", sent_to)
        print("recieving: ", received_from)
        context = { 'user_info' : user_info,
                    'not_friends' : not_friends,
                    'received_from' : received_from,
                    'sent_to' : sent_to,
                    'user_friend_requests' : received_fr_query}

        return render(request,'people.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def like_view(request):
    '''Handles POST Request recieved from clicking Like button in messages.djhtml,
       sent by messages.js, by updating the corrresponding entry in the Post Model
       by adding user to its likes field
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postID,
                                a string of format post-n where n is an id in the
                                Post model

	Returns
	-------
   	  out : (HttpResponse) - queries the Post model for the corresponding postID, and
                             adds the current user to the likes attribute, then returns
                             an empty HttpResponse, 404 if any error occurs
    '''
    postIDReq = request.POST.get('postID')
    print("postIDReq", postIDReq)
    if postIDReq is not None:
        # remove 'post-' from postID and convert to int
        # TODO Objective 10: parse post id from postIDReq
        postID = int(postIDReq[5:])
        current_user = models.UserInfo.objects.get(user=request.user)
        liked_post = models.Post.objects.get(id=postID)
        if request.user.is_authenticated:
            liked_post.likes.add(current_user)
            # TODO Objective 10: update Post model entry to add user to likes field
            
            status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('like_view called without postID in POST')

def post_submit_view(request):
    '''Handles POST Request recieved from submitting a post in messages.djhtml by adding an entry
       to the Post Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postContent, a string of content

	Returns
	-------
   	  out : (HttpResponse) - after adding a new entry to the POST model, returns an empty HttpResponse,
                             or 404 if any error occurs
    '''
    postContent = request.POST.get('postContent')
    if postContent is not None:
        if request.user.is_authenticated:
            user_info = models.UserInfo.objects.get(user=request.user)
            models.Post.objects.create(owner=user_info,content=postContent)
            # COMPLETE Objective 8: Add a new entry to the Post model

            status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('post_submit_view called without postContent in POST')

def more_post_view(request):
    '''Handles POST Request requesting to increase the amount of Post's displayed in messages.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating hte num_posts sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of posts dispalyed
        request.session['post_amount'] += 1
        # COMPLETE Objective 9: update how many posts are displayed/returned by messages_view

        status='success'
        return HttpResponse()

    return redirect('login:login_view')

def more_ppl_view(request):
    '''Handles POST Request requesting to increase the amount of People displayed in people.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating the num ppl sessions variable
    '''
    if request.user.is_authenticated:
        request.session['show_people'] += 1

        # COMPLETE Objective 4: increment session variable for keeping track of num ppl displayed

        status='success'
        return HttpResponse()

    return redirect('login:login_view')

def friend_request_view(request):
    '''Handles POST Request recieved from clicking Friend Request button in people.djhtml,
       sent by people.js, by adding an entry to the FriendRequest Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute frID,
                                a string of format fr-name where name is a valid username

	Returns
	-------
   	  out : (HttpResponse) - adds an etnry to the FriendRequest Model, then returns
                             an empty HttpResponse, 404 if POST data doesn't contain frID
    '''
    frID = request.POST.get('frID')
    if frID is not None:
        # remove 'fr-' from frID
        username = frID[3:]
        print(username)
        if request.user.is_authenticated:
            # COMPLETE Objective 5: add new entry to FriendRequest
            current_user = models.UserInfo.objects.get(user=request.user)
            for user in models.UserInfo.objects.all():
                if str(user.user) == username:
                    try:
                        models.FriendRequest.objects.get(from_user=current_user, to_user=user)
                    except:
                        models.FriendRequest.objects.create(from_user=current_user, to_user=user)
                    break
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('friend_request_view called without frID in POST')

def accept_decline_view(request):
    '''Handles POST Request recieved from accepting or declining a friend request in people.djhtml,
       sent by people.js, deletes corresponding FriendRequest entry and adds to users friends relation
       if accepted
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute decision,
                                a string of format A-name or D-name where name is
                                a valid username (the user who sent the request)

	Returns
	-------
   	  out : (HttpResponse) - deletes entry to FriendRequest table, appends friends in UserInfo Models,
                             then returns an empty HttpResponse, 404 if POST data doesn't contain decision
    '''
    data = request.POST.get('decision')
    print("data", data)
    if data is not None:
        # PARTIAL? DOESNT ALWAYS SEEM TO HAVE DATA Objective 6: parse decision from data
        answer = data[0]
        username = data[2:]
        if request.user.is_authenticated:
            current_user = models.UserInfo.objects.get(user=request.user)
            for user in models.UserInfo.objects.all():
                if str(user.user) == username:
                    if answer == "A":
                        current_user.friends.add(user)
                        user.friends.add(current_user)
                    request = models.FriendRequest.objects.get(from_user=user, to_user=current_user)
                    request.delete()
                    break
        
            # COMPLETE Objective 6: delete FriendRequest entry and update friends in both Users

            status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('accept-decline-view called without decision in POST')
