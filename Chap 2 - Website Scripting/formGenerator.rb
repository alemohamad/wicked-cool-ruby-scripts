require 'cgi'

#Welcome to CGI
cgi = CGI.new("html4Tr")  #html3, html4, html4Tr, or html4Fr

print "Enter Form Page Title: "
title = gets.chomp    #Have user create form title
print "Enter Head Title: "
input_title = gets.chomp     #Have user input title
print "Enter value for button: "
value = gets.chomp
print "Enter group: "
group = gets.chomp

$stdout = File.new("form.html","w")
#Output the CGI form data
cgi.out{
  CGI.pretty(
    cgi.html{
      cgi.head{ "\n"+cgi.title{title}}+
        cgi.body{"\n" +
          cgi.form{"\n" +
            cgi.hr +
            cgi.h1 { "#{input_title}:" } + "\n" +
            cgi.br +
            cgi.checkbox(group, value) + value + cgi.br +
            cgi.br +
            cgi.textarea("input",80,5) + "\n" +
            cgi.br +
            cgi.submit("Send")
        }       
      }
    }
  )
}

$stdout.close