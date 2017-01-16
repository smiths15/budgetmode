class Lesson < ActiveRecord::Base
belongs_to :section
mount_uploader :video, VideoUploader

include RankedModel
ranks :row_order, :with_same => :section_id

def next_lesson
  lesson = section.lessons.where("row_order > ?", self.row_order).rank(:row_order).first
  
  if lesson.blank? && section.next_section
    return section.next_section.lessons.rank(:row_order).first
  end 
  
   return lesson
end

def previous_lesson
  prev_lesson = section.lessons.where("row_order < ?", self.row_order).rank(:row_order).last
  
  if prev_lesson.blank? && section.prev_section
    return section.prev_section.lessons.rank(:row_order).last
  end

  return prev_lesson
end


end
