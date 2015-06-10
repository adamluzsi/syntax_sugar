class SyntaxSugar::NullObject < BasicObject

  VALID_TARGET_METHOD_TYPES = [::String, ::Symbol]
  VALID_METHOD_MATCHERS_TYPES = [::Regexp]

  def initialize(subject_object, regexp_pointers = {})

    @__object__ = subject_object

    unless regexp_pointers.is_a?(::Hash)
      ::Kernel.raise(::ArgumentError, 'method pointer collection should be instance of Hash or Array')
    end

    if regexp_pointers.find{|k,v| !VALID_METHOD_MATCHERS_TYPES.any?{|klass| k.is_a?(klass) } }
      ::Kernel.raise(::ArgumentError,'invalid pointer given in the method definitions, use regular expression')
    end

    if regexp_pointers.find{|k,v| !VALID_TARGET_METHOD_TYPES.any?{|klass| v.is_a?(klass) } }
      ::Kernel.raise(::ArgumentError,'invalid target method given in the method definitions, use string or symbol')
    end

    @regexp_pointers = regexp_pointers

  end

  def method_missing(method_name, *args, &block)

    @regexp_pointers.each do |regexp, target_method|

      if method_name.to_s =~ regexp

        if regexp.source =~ /\(.*\)/
          method_extraction = method_name.to_s.scan(regexp)[0][0]
          args.unshift(method_extraction)
        end

        return @__object__.__send__(
            target_method,
            *args, &block
        )

      end

    end

    ::Kernel.raise(::NameError,"undefined local variable or method `#{method_name}' for #{@__object__.inspect}:SyntaxSugar::NullObject")

  end

end