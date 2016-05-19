class UserSearchService
  def initialize(params)
    @users = User.all
    filter_by_role(params[:role])
    filter_by_art(params[:art_id])
  end

  def filter_by_role(role)
    @users = @users.where(role: User.roles[role]) if role.present?
  end

  def filter_by_art(art_id)
    @users = @users.where(art_id: art_id) if art_id.present?
  end

  def results
    @users
  end
end
