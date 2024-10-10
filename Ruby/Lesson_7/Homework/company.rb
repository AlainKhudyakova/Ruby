module Company
  attr_reader :company_name

  def specify_company(name)
    self.company_name = name
  end

  def show_company
    company_name
  end

  protected

  attr_writer :company_name
end