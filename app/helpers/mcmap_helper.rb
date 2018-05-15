module McmapHelper
  def generate_sample_checkboxes(number, col = 3)
    i = 0
    html_string = ''
    while i < number do
      html = "<div class='col-md-#{col} col-sm-#{col}'>
      <label class='checkbox-inline'>
        <input type='checkbox' value=''> #{Faker::Name.first_name}
      </label>
    </div>"
      html_string += html
      i += 1
    end
    html_string.html_safe
  end

  def generate_sample_modal_data(number)
    i = 0
    html_string = ''
    ingredient_array = []
    20.times do
      ingredient_array.push(Faker::Food.ingredient)
    end
    while i < number do
      ingredients = ingredient_array.sample(rand(2..10)).join(', ')
      html = "
      <div class='col-md-12 col-sm-12'>
          <a href='#{hospital_detail_path}'>#{Faker::Company.name}</a>
      </div>
      <div class='col-md-8 col-sm-8'>
         #{Faker::Address.street_address} - #{Faker::Address.city}
      </div>
       <div class='col-md-4 col-sm-4 float-right'>
         #{Faker::Company.duns_number}
      </div>
      <div class='col-md-12 col-sm-12'>
        #{ingredients}
      </div>
      <div class='col-md-12 col-sm-12'>
        <hr>
      </div>"
      html_string += html
      i += 1
    end
    html_string.html_safe
  end

end