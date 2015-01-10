require 'win32ole'

#Start Internet Explorer
ie = WIN32OLE.new('InternetExplorer.Application')
#Navigate to the page specified
ie.navigate("http://toolbar.google.com/send/sms/index.php")

#Set this to true if you want the IE window to be visible, false otherwise
ie.visible = true
#Wait for the page to fully load before moving on
sleep 1 until ie.readyState() == 4

#Fill in the form on the website
ie.document.all["mobile_user_id"].value ="1234567890"
ie.document.all["carrier"].value ="TMOBILE"
ie.document.all["subject"].value ="***Ruby Rulez***"
ie.document.all.tags("textarea").each do |i|
  i.value = "Thanks for the hard work, Matz!"
end

#click the send button
ie.document.all.send_button.click