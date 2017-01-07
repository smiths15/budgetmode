class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_to_view, only: [:show]

  def show
    
  end

  private

  def require_enrollment_to_view
    current_course = current_lesson.section.course
    if current_user.enrolled_in?(current_course) != true
      redirect_to course_path(current_course), alert: 'Please enroll to see lesson details'  
    end  
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end


end
