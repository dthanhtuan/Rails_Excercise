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
      html_string += model_body(ingredients)
      i += 1
    end
    html_string.html_safe
  end

  def model_body(ingredients)
    "
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
  end

  def generate_sample_table(number, type = 'mark')
    return table_row_with_mark(number, type) if %w[mark no_mark].include?(type)
    table_empty_row(number) if type == 'empty'
  end

  def table_row_with_mark(number, type)
    rand_string = generate_random_string(rand(2..5))
    html_string = "<tr>
                      <td class='col-md-1 one-word-per-line blue-bg text-center' rowspan='#{number}'>#{rand_string}</td>
                      <td class='light-blue-bg'>#{Faker::HarryPotter.character}</td>"
    html_string += "<td class='col-md-2 text-center'>#{['O', ''].sample(rand(1..2)).last}</td>" if type == 'mark'
    html_string += "<td class='col-md-6 text-center'></td>" if type == 'no_mark'
    html_string += '</tr>'
    html_string += generate_multiple_row(number, type)
    html_string.html_safe
  end

  def generate_multiple_row(number, type)
    i = 0
    html_string = ''
    while i < (number - 1)
      html = "<tr>
               <td class='light-blue-bg'>#{Faker::HarryPotter.character}</td>"
      html += "<td class='col-md-2 text-center'>#{['O', ''].sample(rand(1..2)).last} </td>" if type == 'mark'
      html += "<td class='col-md-6 text-center'></td>" if type == 'no_mark'
      html += '</tr>'
      html_string += html
      i += 1
    end
    html_string
  end

  def table_empty_row(number)
    rand_string = generate_random_string(number)
    html_string = "
         <td class='col-md-1 one-word-per-line blue-bg text-center' rowspan='2'>#{rand_string}</td>
          <td rowspan='2' colspan='2'></td>
      "
    html_string.html_safe
  end

  def generate_random_string(number)
    [*('A'..'Z')].sample(number).join
  end

  def generate_bing_map
    javascript_include_tag
  end

end