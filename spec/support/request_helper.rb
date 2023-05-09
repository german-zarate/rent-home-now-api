module RequestHelper
  def sign_in(user)
    token = JwtToken.sign({ user_id: user.id })
    request.headers['Authorization'] = token
  end
end
