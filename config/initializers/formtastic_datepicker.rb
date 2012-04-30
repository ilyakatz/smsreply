module Formtastic::Inputs
  class UiDatePickerInput < Formtastic::Inputs::StringInput

    def input_html_options
      new_class = [super[:class], css_class].compact.join(" ")
      super.update(:class => new_class, :value => localized(object.send(method)))
    end

  end
end