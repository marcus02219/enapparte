if Setting.table_exists?
  Setting.save_default :default_from_email, '86d18b807e91e6d4a8bc3cf6bab924d2@inbound.postmarkapp.com'
end
