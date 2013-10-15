"""
sassd

An ultra minimalist Sass/Compass Compilation Daemon based
on the Sinatra web framework.
"""

require 'rubygems'
require 'sinatra'
require 'sass'

SYNTAX_SCSS = :scss
SYNTAX_SASS = :sass
CONTENT_TYPE_CSS = 'text/css'
CONTENT_TYPE_PLAIN = 'text/plain'


# Compile sass/scss into css
def compile(src, syntax)
    options = {}
    options[:syntax] = syntax
    options[:compass] ||= {}
    #options[:compass][:logger] = self.logger
    options[:compass][:environment] = Compass.configuration.environment

    engine = Sass::Engine.new(src, options)
    css = engine.to_css()
    return css
end


# Display a Sass::SyntaxError to the client
def displaySyntaxError(exc)
    status 400
    headers["Content-Type"] = CONTENT_TYPE_PLAIN;
    return "Caught Syntax Error: " + exc
end


# Return CSS to the client
def displayCSS(css)
    headers["Content-Type"] = CONTENT_TYPE_CSS;
    return css
end


# Handle Compilation Request
def handleCompileRequest(syntax)
    request.body.rewind()
    scss = request.body.read()

    begin
        css = compile(scss, syntax)
    rescue Sass::SyntaxError => e
        return displaySyntaxError(e)
    end

    return displayCSS(css)
end


# Route for compiling SCSS -> CSS
post '/scss' do
    return handleCompileRequest(SYNTAX_SCSS)
end


# Route for compiling SASS -> CSS
post '/sass' do
    return handleCompileRequest(SYNTAX_SASS)
end
