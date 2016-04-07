class String
  def convert_to_basename
    gsub(/[^a-z\s\_]/i, '').split.join(" ").downcase.gsub(/\s+/,"_")
  end
end