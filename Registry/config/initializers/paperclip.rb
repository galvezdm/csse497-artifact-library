Paperclip.interpolates :artifact do |attachment, style|
  attachment.instance.artifact.id
end

Paperclip.interpolates :name do |attachment, style|
  attachment.instance.name
end

Paperclip.interpolates :extension do |attachment, style|
  attachment.instance.extension
end

Paperclip.interpolates :user do |attachment, style|
  attachment.instance.user.id
end