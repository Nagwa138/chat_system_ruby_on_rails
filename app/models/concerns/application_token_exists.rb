class ApplicationTokenExists < ActiveModel::Validator
  def validate(record)
    unless Application.exists?(token: record.application_id)
      record.errors.add :application_token, "This application does not exist!"
    end
  end
end