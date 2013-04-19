module HeaderMenuLinksHelper
  def header_menu_links
    a = Array.new
    a << {image: "task.jpg", link: standards_path, link_text: t(".standards")}
    a << {image: "help.jpg", link: current_user.super_admin? ? admin_helps_path : helps_path, link_text: t(".help")}
    a << {image: "news-ico.jpg", link: current_user.super_admin? ? admin_news_index_path : news_index_path, link_text: t(".news")}
    if current_user.super_admin?
      a << {image: "admin_ico.png", link: admin_users_path, link_text: t(".admin_room")}
    end
    a
  end
end