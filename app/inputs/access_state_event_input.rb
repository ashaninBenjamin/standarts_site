class AccessStateEventInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def collection
    object.send("access_state_transitions")
  end

  def input
    label_method = :human_event
    value_method = :event

    @builder.collection_radio_buttons(
        attribute_name, collection, value_method, label_method,
        input_options, input_html_options, &collection_block_for_nested_boolean_style
    )
  end

end