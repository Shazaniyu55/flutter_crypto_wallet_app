# CryptoWallet App

A Flutter-based cryptocurrency wallet app that supports multiple currencies, using the GetX state management library and MongoDB for data storage.

## Features

- **Multi-Currency Support**: View and manage various cryptocurrencies.
- **Real-Time Data**: Fetch up-to-date cryptocurrency prices.
- **User-Friendly Interface**: Clean and intuitive design.

## Technologies Used

- **Flutter**: Framework for building natively compiled applications for mobile from a single codebase.
- **GetX**: A powerful and lightweight state management solution for Flutter.
- **MongoDB**: NoSQL database for storing user data and application state.

## Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/cryptowallet.git
    ```

2. **Navigate to the project directory**:
    ```bash
    cd cryptowallet
    ```

3. **Install dependencies**:
    ```bash
    flutter pub get
    ```

4. **Set up MongoDB**:
    - Make sure you have MongoDB installed. Follow the [MongoDB installation guide](https://docs.mongodb.com/manual/installation/) if needed.
    - Start your MongoDB server:
      ```bash
      mongod
      ```

5. **Configure MongoDB Connection**:
    - Create a `.env` file in the root of the project.
    - Add your MongoDB connection string to the `.env` file:
      ```env
      MONGO_URI=mongodb://your-mongodb-uri
      ```

6. **Run the app**:
    ```bash
    flutter run
    ```

## Configuration

### API Keys

The app requires API keys to fetch cryptocurrency data. To configure:

1. Obtain API keys from your chosen cryptocurrency data provider.
2. Add the following environment variables to the `.env` file:
    ```env
    API_KEY=your_api_key_here
    ```

3. Update the relevant code to use these environment variables.

### MongoDB Configuration

1. **Ensure MongoDB is running**: Verify that your MongoDB instance is up and running.
2. **Update MongoDB connection**: Ensure your application code uses the connection string from the `.env` file.

### Flutter Configuration

Make sure you have Flutter installed and set up on your system. For more details, refer to the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

## Usage

1. **Open the app**: Start the application on your emulator or physical device.
2. **Navigate through the app**: Use the UI to view and manage different cryptocurrencies.

## Project Structure

- **lib**: Contains the Dart code for the application.
  - **models**: Data models for the app.
  - **services**: Services for fetching cryptocurrency data and interacting with MongoDB.
  - **controllers**: GetX controllers for state management.
  - **views**: UI components and pages.
  - **utils**: Utility functions and classes.
- **assets**: Contains images and other assets used in the app.
- **pubspec.yaml**: Flutter project configuration file.

## Contributing

1. **Fork the repository**.
2. **Create a feature branch**:
    ```bash
    git checkout -b feature/your-feature
    ```
3. **Commit your changes**:
    ```bash
    git commit -am 'Add new feature'
    ```
4. **Push to the branch**:
    ```bash
    git push origin feature/your-feature
    ```
5. **Create a pull request**.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or feedback, please reach out to [your-email@example.com](mailto:your-email@example.com).

---

Feel free to update the repository URL, MongoDB URI, API configuration, and contact information as needed. Happy coding!
