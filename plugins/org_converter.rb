# A generator that uses a emacs invoked in batch mode to process
# org-mode files into html

require 'open3'

module Jekyll

  class OrgModeConverter < Converter
    safe false
    priority :low

    @@emacs_org_html_cmd = "(progn (require (quote org)) (setq org-html-head-include-default-style nil) (setq org-html-head-include-scripts nil) (condition-case nil (while t (insert (read-string \"\") \"\n\")) (error nil)) (set-buffer (org-export-to-buffer (quote html) \"*Org HTML Export*\" nil nil nil t nil (lambda nil t))) (message \"%s\" (buffer-string)))"

    def matches(ext)
      ext =~ /^\.org$/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      emacs_path = if ENV.has_key?("EMACS")
                     ENV["EMACS"]
                   else
                     `which emacs`
                   end

      if emacs_path.empty?
        puts "Could not find an emacs executable."
      else
        out, status = Open3.capture2e("#{emacs_path} --batch --eval " +
                                      "#{@@emacs_org_html_cmd.inspect}",
                                      :stdin_data=>content)
        out unless status != 0
      end

    end
  end
end
