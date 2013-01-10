module ProjectsHelper
  def project_link(subdomain)
    link_to subdomain, "http://#{subdomain}.#{request.host}"
  end
end
