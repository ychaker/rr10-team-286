require 'nokogiri'
require 'open-uri'

module Gemcutter
  
  class SearchResult
    attr :name, true
    attr :info, true
    attr :version, true
    attr :version_downloads, true
    attr :authors, true
    attr :downloads, true
    attr :project_uri, true
    attr :gem_uri, true
    attr :homepage_uri, true
    attr :wiki_uri, true
    attr :documentation_uri, true
    attr :mailing_list_uri, true
    attr :source_code_uri, true
    attr :bug_tracker_uri, true
    attr :runtime_dependencies, true
    attr :development_dependencies, true
    
    
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
    
  end
  
  BASE_URI = 'http://rubygems.org'
  
  def self.search(name)
    doc = Nokogiri::XML(open(BASE_URI + "/api/v1/search.xml?query=#{name}"))
    @gems = doc.xpath("//rubygems/rubygem").map do |each|
      SearchResult.new( 
      { :name                     => each.xpath('name').text, 
        :info                     => each.xpath('info').text, 
        :version                  => each.xpath('version').text, 
        :version_downloads        => each.xpath('version-downloads').text, 
        :authors                  => each.xpath('authors').text, 
        :downloads                => each.xpath('downloads').text, 
        :project_uri              => each.xpath('project-uri').text, 
        :gem_uri                  => each.xpath('gem-uri').text, 
        :homepage_uri             => each.xpath('homepage-uri').text, 
        :wiki_uri                 => each.xpath('wiki-uri').text, 
        :documentation_uri        => each.xpath('documentation-uri').text, 
        :mailing_list_uri         => each.xpath('mailing-list-uri').text, 
        :source_code_uri          => each.xpath('source-code-uri').text, 
        :bug_tracker_uri          => each.xpath('bug-tracker-uri').text, 
        :runtime_dependencies     => each.xpath('dependencies/runtime/dependency').inject([]){
          |dependencies, dependency| 
          dependencies << { :name => dependency.xpath('name').text, :requirements =>  dependency.xpath('requirements').text }},
        :development_dependencies => each.xpath('dependencies/development/dependency').inject([]){
            |dependencies, dependency| 
            dependencies << { :name => dependency.xpath('name').text, :requirements =>  dependency.xpath('requirements').text }},
      })
    end
  end
  
  def self.rubygem(name)
    begin
      doc = Nokogiri::XML(open(BASE_URI + "/api/v1/gems/#{name}.xml"))
      @gem = SearchResult.new( 
      {   :name                     => doc.xpath('//rubygem/name').text, 
          :info                     => doc.xpath('//rubygem/info').text, 
          :version                  => doc.xpath('//rubygem/version').text, 
          :version_downloads        => doc.xpath('//rubygem/version-downloads').text, 
          :authors                  => doc.xpath('//rubygem/authors').text, 
          :downloads                => doc.xpath('//rubygem/downloads').text, 
          :project_uri              => doc.xpath('//rubygem/project-uri').text, 
          :gem_uri                  => doc.xpath('//rubygem/gem-uri').text, 
          :homepage_uri             => doc.xpath('//rubygem/homepage-uri').text, 
          :wiki_uri                 => doc.xpath('//rubygem/wiki-uri').text, 
          :documentation_uri        => doc.xpath('//rubygem/documentation-uri').text, 
          :mailing_list_uri         => doc.xpath('//rubygem/mailing-list-uri').text, 
          :source_code_uri          => doc.xpath('//rubygem/source-code-uri').text, 
          :bug_tracker_uri          => doc.xpath('//rubygem/bug-tracker-uri').text, 
          :runtime_dependencies     => doc.xpath('//rubygem/dependencies/runtime/dependency').inject([]){
            |dependencies, dependency| 
            dependencies << { :name => dependency.xpath('name').text, :requirements =>  dependency.xpath('requirements').text }},
          :development_dependencies => doc.xpath('dependencies/development/dependency').inject([]){
              |dependencies, dependency| 
              dependencies << { :name => dependency.xpath('name').text, :requirements =>  dependency.xpath('requirements').text }},
      })
    rescue Exception
    end
  end
end