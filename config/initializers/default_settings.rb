if Setting.table_exists?
  Setting.save_default :default_from_email, 'no-reply@enapparteparis.com'
end
