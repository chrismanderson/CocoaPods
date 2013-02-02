module Pod
  module Generator

    class Acknowledgements

      # @return [Array<Class>] The classes of the acknowledgements generator
      #         subclasses.
      #
      def self.generators
        [Plist, Markdown]
      end

      # @return [Array<Sandbox::FileAccessor>] the list of the file accessors
      #         for the specs of the target that needs to generate the
      #         acknowledgements.
      #
      attr_reader :file_accessors

      # @param [Array<Sandbox::FileAccessor>] @see file_accessors.
      #
      def initialize(file_accessors)
        @file_accessors = file_accessors
      end

      #-----------------------------------------------------------------------#

      # !@group Configuration

      # @return [String] The title of the acknowledgements file.
      #
      def header_title
        "Acknowledgements"
      end

      # @return [String] A text to present before listing the acknowledgements.
      #
      def header_text
        "This application makes use of the following third party libraries:"
      end

      # @return [String] The title of the foot notes.
      #
      def footnote_title
        ""
      end

      # @return [String] the foot notes.
      #
      def footnote_text
        "Generated by CocoaPods - http://cocoapods.org"
      end

      #-----------------------------------------------------------------------#

      private

      # !@group Private methods

      # @return [Array<Specification>] The root specifications for which the
      #         acknowledgements should be generated.
      #
      def specs
        file_accessors.map{ |accessor| accessor.spec.root }.uniq
      end

      # Returns the text of the license for the given spec.
      #
      # @param  [Specification] spec
      #         the specification for which license is needed.
      #
      # @return [String] The text of the license.
      # @return [Nil] If not license text could be found.
      #
      def license_text(spec)
        if spec.license
          if text = spec.license[:text]
            text
          elsif license_file = file_accessor(spec).license
            text = IO.read(license_file)
          end
        end
      end

      protected

      # Returns the file accessor for the given spec.
      #
      # @param  [Specification] spec
      #         the specification for which the file accessor is needed.
      #
      # @return [Sandbox::FileAccessor] The file accessor.
      #
      def file_accessor(spec)
        file_accessors.find { |accessor| accessor.spec.root == spec }
      end

      #-----------------------------------------------------------------------#

    end
  end
end
