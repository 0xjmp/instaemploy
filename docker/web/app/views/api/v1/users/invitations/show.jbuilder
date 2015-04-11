json.invitation do
  json.partial! 'api/v1/users/invitations/invitation', invitation: @invitation, as: :invitation
end