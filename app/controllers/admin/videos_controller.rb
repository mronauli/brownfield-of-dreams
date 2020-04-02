class Admin::VideosController < Admin::BaseController
  def edit
    @video = Video.find(params[:id])
  end

  def update
    video = Video.find(params[:id])
    video.update(new_video_params)
    tutorial = video.tutorial
    redirect_to tutorial_path(tutorial)
  end

  def create
    tutorial = Tutorial.find(params[:tutorial_id])
    thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
    video = tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))
    video.save
    redirect_to edit_admin_tutorial_path(id: tutorial.id)
  end

  private
    def new_video_params
      params.require(:video).permit(:title, :description, :video_id, :thumbnail)
    end
end
