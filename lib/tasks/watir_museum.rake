desc "watir museum data"
task :watir_museum, [:tp]  => [:environment] do |t, args|
  b = Watir::Browser.new :chrome, headless: true, options: {args: ['--no-sandbox']}
  b.goto("https://www.museumsusa.org/museums/?k=1271407%2cCategoryID%3a200050%3bState%3aCA%3bDirectoryID%3a200454")
  
  page = 0
  while true
    p "---------scrab page #{page}-----------"
    b.div(class: "itemGroup").children(class: "basic").each{|node| 
      name = node.div(class: "party").children.first.text
      city, state = node.div(class: "location").text.strip.split(",")
      if node.div(class: "abstract").present?
        description = node.div(class: "abstract").text.strip
      end

      museum = Museum.where(name: name).first_or_initialize
      museum.city = city
      museum.state = state
      museum.description = description
      museum.save

      p [name, city, state]
    }

    if b.span(id: "ctl11_ctl00_TopPager").children.last.text == "Next"
      page += 1
      b.span(id: "ctl11_ctl00_TopPager").children.last.fire_event("click")
    else
      break
    end
  end
end