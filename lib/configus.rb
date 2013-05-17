#encoding: utf-8
Configus.build Rails.env do
  env :production do
    carrierwave do
      storage :fog
    end

    super_admin do
      user do
        login "admin"
        password "123"
      end
      profile do
        surname "Иванов"
        name "Иван"
        patronymic "Иванович"
        mail "mail@mail.ru"
      end
      company do
        opf "ООО"
        name "The Standard's Company"
      end
    end
    role do
      super_admin do
        name "super"
        description "Супер администратор"
      end
      admin do
        name "admin"
        description "Администратор"
      end
    end
  end

  env :development do
    carrierwave do
      storage :file
    end

    super_admin do
      user do
        login "admin"
        password "123"
      end
      profile do
        surname "Иванов"
        name "Иван"
        patronymic "Иванович"
        mail "mail@mail.ru"
      end
      company do
        opf "ООО"
        name "The Standard's Company"
      end
    end
    role do
      super_admin do
        name "super"
        description "Супер администратор"
      end
      admin do
        name "admin"
        description "Администратор"
      end
    end
  end

  env :test, parent: :development do
  end
end