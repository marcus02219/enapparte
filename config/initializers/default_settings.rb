if Setting.table_exists?
  Setting.save_default :default_from_email, 'no-reply@enapparteparis.com'
  Setting.save_default :host, 'enapparteparis.com'
end
