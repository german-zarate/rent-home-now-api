<a name="readme-top"></a>

<div align="center">
  <img src="./app/assets/images/logo.png" alt="logo" width="140"  height="auto" />
  <h1><b>Rent Home Now API</b></h1>
</div>

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Frontend Repository](#frontend)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [🚀 Live Demo](#live-demo)
  - [🧮 Kanban Board](#kanban-bord)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
  - [Deployment](#triangular_flag_on_post-deployment)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🔭 Acknowledgements](#acknowledgements)
- [❓ FAQ](#faq)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 🎯 Rent Home Now API<a name="about-project"></a>

Rent Home Now API is the final capstone project for the Full Stack Developer Program at Microverse.

Rent Home Now API is RESTful API that facilitates the connection between property owners interested in renting out their properties and potential renters. The API allows for the creation of reservations on selected properties. It has been developed using the Ruby on Rails framework and uses a PostgreSQL database.

The app was built with a Ruby on Rails backend and a React/Redux frontend, located on separate repositories.

## 🛠 Frontend repository: <a name="frontend"></a>

To visit the frontend repository, please [click here](https://github.com/shahadat3669/rent-home-now.git).

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Technology</summary>
  <ul>
    <li>Ruby</li>
    <li>Rails</li>
    <li>PostgresSQL</li>
  </ul>
</details>

<details>
  <summary>Tools</summary>
  <ul>
    <li>VS Code</li>
    <li>GIT</li>
    <li>GITHUB</li>
  </ul>
</details>

<!-- Features -->

### Key Features <a name="key-features"></a>

Main functionalities which the app will have:

- **User registration:** Allow new users to register an account with the API by providing their personal information and creating a username and password.
- **Property listing:** Allow property owners to list their properties with the API by providing information such as property type, location, price, and availability.
- **Reservation creation:** Allow renters to create reservations for selected properties by providing the desired dates of the reservation and the number of occupants.
- **Reservation management:** Allow both property owners and renters to view, edit, and cancel existing reservations.
- **API documentation:** Provide comprehensive documentation for the API, including endpoints, parameters, responses, and error messages, to facilitate integration with external clients and applications.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LIVE DEMO -->

## 🚀 Live Demo <a name="live-demo"></a>

Sorry, Currently no active link available.

<!-- - [Live Demo Link]() -->

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🧮 Kanban Board <a name="kanban-bord"></a>

- [Kanban Board link.](https://github.com/users/shahadat3669/projects/9)
- [Kanban Board initial state.](https://user-images.githubusercontent.com/55840999/236042261-3f31ae1b-e926-482f-b679-621648fe009a.png)
- Number of team members at start and finish: 3 Team members.

<!-- - [Live Demo Link]() -->

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running follow these simple example steps.

### Prerequisites

you have to those tools in your local machine.

- [ ] Ruby
- [ ] Rails
- [ ] PostgresSQL
- [ ] GIT & GITHUB
- [ ] Any Code Editor (VS Code, Brackets, etc)

### Clone Repository

Clone the repository using the following bash command in an appropriate location.

```bash
  git clone git@github.com:shahadat3669/rent-home-now-api.git
```

Go to the project directory.

```bash
  cd rent-home-now-api
```

### Adding credentials

Rails stores secrets in `config/credentials.yml.enc`, which is encrypted and hence cannot be edited directly. Rails uses `config/master.key`. If you have the master key, to add or change credentials in your terminal, run this command (change the name of you editor if you need for example code for VS Code)

```bash
  EDITOR="code" rails credentials:edit
```

This command will create the credentials file if it does not exist. Additionally, this command will create config/master.key if no master key is defined.
Here pass the --wait flag to make sure the encryption happens after the edits have been saved and the editor closed.

```bash
  EDITOR="code --wait" rails credentials:edit
```

The scaffolded credentials.yml.enc looks like below:

```bash
  postgres_password: Database User Password
  smtp_user_name: SMTP User name
  smtp_password: SMTP User password
```

To learn more [check Custom Credentials](https://edgeguides.rubyonrails.org/security.html#custom-credentials) documentation.

### Add necessary packages

For installing necessary packages, run the following bash command:

```bash
  bundle install
```

### Setup Database locally

For setup database locally, run the following bash commands:

- Create a database in your local machine

```bash
  rails db:create
```

- Run necessary migrations

```bash
  rails db:migrate
```

- To insert seeds in the database, you can run:

```bash
  rails db:seed
```

### Run the server in development mode

In the project directory, you can run the project by using following bash command:

```bash
  ./bin/dev
```

And now you can visit the site with the URL http://localhost:4000

### Run the test

Before running the test command, please make sure you have run `rails db:seed`.

For testing you can run following bash command:

```bash
  bundle exec rspec --exclude-pattern "spec/requests/api/**/*"
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

### First Author:

**Shahadat Hossain**

[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://github.com/shahadat3669) [![linkedin](https://img.shields.io/badge/shahadat3669-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](www.linkedin.com/in/shahadat3669) [![twitter](https://img.shields.io/badge/@shahadat3669-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/shahadat3669)

### Second Author:

**Sandro Hernandez**

[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://sambeck87.github.io/setup_and_mobile_first) [![linkedin](https://img.shields.io/badge/sandro_israel_hernández_zamora-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](www.linkedin.com/in/sandro-israel-hernández-zamora-899386a4) [![twitter](https://img.shields.io/badge/@sambeck4488-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/sambeck4488)

### Third Author:

**Sandro Hernandez**

[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://gutemag.github.io/) [![linkedin](https://img.shields.io/badge/Birhanu_Gudisa-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](www.linkedin.com/in/birhanugudisa-899386a4) [![twitter](https://img.shields.io/badge/@birhanugudisa3-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/birhanugudisa3)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🔭 Future Features <a name="future-features"></a>

- [ ] **Payment integration:** Allow renters to pay for their reservations through the API using a secure payment gateway.

- [ ] **Rating and review system:** Allow renters to rate and review properties they have rented through the API, and allow property owners to view and respond to these reviews.
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## 👋 Show your support <a name="support"></a>

Give a ⭐️ if you like this project!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGEMENTS -->

## 🔭Acknowledgments <a name="acknowledgements"></a>

- My Family.
- [Microverse](microverse.org)
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FAQ (optional) -->

## ❓ FAQ <a name="faq"></a>

- **Can I use this project for personal use?**

  - Yes, you can use it.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
