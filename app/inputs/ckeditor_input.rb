class CkeditorInput < ::SimpleForm::Inputs::Base
  def input_html_classes
    super.push('ckeditor')
  end
end