class AddAttachmentPictureToAvatars < ActiveRecord::Migration
  def self.up
    change_table :avatars do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :avatars, :picture
  end
end
