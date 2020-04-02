class FriendInviteMailer < ApplicationMailer
  def github_invite(user, friend)
     @user = user
     @friend = friend
     mail(to: @friend.email, subject: "Github Invite")
  end
end
