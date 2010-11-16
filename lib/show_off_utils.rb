class ShowOffUtils
  def self.showoff_author(dir = '.')
    index = File.join(dir, ShowOffUtils::SHOWOFF_JSON_FILE )
    order = nil
    if File.exists?(index)
      data = JSON.parse(File.read(index))
      data.is_a?(Hash) && data['author'] || "Anonymous"
    end
  end

  def self.showoff_description(dir = '.')
    index = File.join(dir, ShowOffUtils::SHOWOFF_JSON_FILE )
    order = nil
    if File.exists?(index)
      data = JSON.parse(File.read(index))
      data.is_a?(Hash) && data['description'] || ""
    end
  end
end