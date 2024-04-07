def find_trix_editor(id)
  find(:xpath, "//*[@id='#{id}']", visible: false)
end
