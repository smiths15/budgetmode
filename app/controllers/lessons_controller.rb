class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_to_view, only: [:show]

  def show
    
  end

  private

  def require_enrollment_to_view
    enrolled = current_user.enrollment_ids & current_lesson.section.course.enrollment_ids
    if enrolled.empty?
      redirect_to course_path(current_lesson.section.course_id), alert: 'Error Message Here'  
    end  
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end


end
