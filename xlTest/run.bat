MKDIR %cd%
cd %cd%\lib
ruby main.rb
cd ..
START chrome.exe %cd%\test_report\module_1\report.html
pause
