module McmapHelper
  def generate_sample_checkboxes(number)
    i = 0
    html_string = ''
    while i < number do
      html = "<div class='col-md-3'>
      <label class='checkbox-inline'>
        <input type='checkbox' value=''> #{Faker::Name.first_name}
      </label>
    </div>"
      html_string += html
      i += 1
    end
    html_string.html_safe
  end

end