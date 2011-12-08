require 'yaml'

module Buffet
  class Settings
    SETTINGS_FILE          = 'buffet.yml'
    DEFAULT_PREPARE_SCRIPT = 'bin/before-buffet-run'

    class << self
      def [](name)
        @settings ||= YAML.load_file(SETTINGS_FILE)
        @settings[name]
      end

      def slaves
        @slaves ||= self['slaves'].map do |slave_hash|
          Slave.new slave_hash['user'], slave_hash['host'], project
        end
      end

      def project
        @project ||= begin
          project = self['project']
          Project.new(project['name'], project['directory'])
        end
      end

      def framework
        self['framework'].upcase || 'RSPEC1'
      end

      def prepare_script
        self['prepare_script'] || DEFAULT_PREPARE_SCRIPT
      end

      def has_prepare_script?
        self['prepare_script'] || File.exist?(DEFAULT_PREPARE_SCRIPT)
      end

      def reset!
        @settings = nil
      end
    end
  end
end
