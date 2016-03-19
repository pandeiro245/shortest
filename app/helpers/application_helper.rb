module ApplicationHelper
  def parse_http str
    str.gsub(/https?:\/\/[a-zA-Z0-9.\/_\-~?%=&]*/){|text_all|
      a = text_all.split(" ")
      helper = ApplicationController.helpers
      if a.length == 1
        tr = helper.truncate(text_all, length:45)
        "<a href=\"#{text_all}\" target=\"_blank\"><i class=\"fa fa-link\"></i></a>"
      else
        tr = helper.truncate(a[0], length:45)
        "<a href=\"#{a[0]}\" target=\"_blank\"><i class=\"fa fa-link\"></i></a>#{a[1]}"
      end
    }
  end
end
