module ApplicationHelper
  def angular_templates(templates_path)
    templates = Dir[templates_path + '**/*'].select { |f| File.file? f }
    templates.inject('') do |js, template|
      rendered = render(file: template)
      template_id = Pathname.new(template.gsub(/\.(\w+)$/, ''))
                            .relative_path_from(Pathname.new(templates_path))
      js + content_tag(:script, rendered, id: template_id,
                                          type: 'text/ng-template')
    end
  end
end
