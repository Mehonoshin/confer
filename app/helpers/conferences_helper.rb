module ConferencesHelper
  def human_date_with_time(date)
    date.strftime("%d.%m.%Y %H:%M") if date
  end

  def human_date(date)
    date.strftime("%d.%m.%Y") if date
  end

  def conference_site_link(conference, &block)
    if block
      link_to url_for(controller: :main, host: request.host, subdomain: conference.domain) do
        yield
      end
    else
      link_to conference.name, url_for(controller: :main, host: request.host, subdomain: conference.domain)
    end
  end

end
