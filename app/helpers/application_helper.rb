module ApplicationHelper
  def hm_types_collection
    [
      ['weight', '1'],
      ['height', '2'],
      ['steps', '3'],
      ['heart rate', '4'],
      ['calories', '5'],
      ['running', '6'],
      ['walking', '7'],
      ['cycling', '8'],
      ['sleeping', '9']
    ]     
  end

  def hm_units_hash
    {
      '1' => 'kg',
      '2' => 'cm',
      '3' => 'steps',
      '4' => 'heart rate',
      '5' => 'calories',
      '6' => 'km running',
      '7' => 'km walking',
      '8' => 'km cycling',
      '9' => 'hrs sleeping'
    }
  end

  def hm_units_collection
    [
      ['kg', '1'],
      ['cm', '2'],
      ['steps', '3'],
      ['heart rate', '4'],
      ['calories', '5'],
      ['km running', '6'],
      ['km walking', '7'],
      ['km cycling', '8'],
      ['hrs sleeping', '9']
    ]   
  end

  def objectives_collection
    [
      ["less than", "<"],
      ["at most", "<="],
      ["more than", ">"],
      ["at least", ">="]
    ]
  end
end
