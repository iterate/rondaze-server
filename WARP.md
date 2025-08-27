# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

Rondaze Backend is a Node.js Express application that manages high scores for a game using Supabase as the database. The project follows a simple MVC-style architecture with ES modules.

## Development Commands

### Setup and Installation
```bash
npm install                    # Install dependencies
```

### Running the Application
```bash
npm start                     # Start production server (node src/server.js)
npm run dev                   # Start development server with hot reload (nodemon)
```

### Docker
```bash
docker build -t rondaze-server .
docker run -p 8080:8080 rondaze-server
```

## Environment Configuration

The application requires a `.env` file in the root directory with:
```
SUPABASE_URL=<your-supabase-url>
SUPABASE_KEY=<your-supabase-api-key>
PORT=3002                     # Optional, defaults to 3002
```

## Architecture

### Project Structure
- `src/server.js` - Main application entry point and Express server configuration
- `src/controllers/` - Business logic controllers
- `src/routes/` - Express route definitions
- `src/db/` - Database client configuration

### Key Components

**Server Setup (`src/server.js`)**
- Initializes Express app with CORS and JSON parsing
- Configures Supabase client
- Sets up routes and middleware
- Includes request logging and error handling
- Tests database connection on startup

**Database Layer (`src/db/supabaseClient.js`)**
- Exports configured Supabase client
- Handles environment variable loading

**Controllers (`src/controllers/highScoresController.js`)**
- `HighScoresController` class manages high score operations
- Methods: `getHighScores()`, `addHighScore()`
- Handles error logging and response formatting

**Routes (`src/routes/highScoresRoutes.js`)**
- Defines REST endpoints for high scores API
- GET/POST `/api/highscores`
- Binds controller methods to routes

### Database Schema
- Table: `high_scores`
- Fields: `username` (string), `score` (number)
- API expects: `playerName` (maps to username), `score`

## API Endpoints

- `GET /api/highscores` - Retrieve all high scores (ordered by score DESC)
- `POST /api/highscores` - Add new high score (requires `playerName` and `score`)
- `GET /api/test` - Health check endpoint

## Development Notes

- Uses ES modules (`"type": "module"` in package.json)
- Server listens on all interfaces (`0.0.0.0`) for Docker compatibility
- Default port is 3002, configurable via PORT environment variable
- Includes comprehensive error handling and logging
- CORS enabled for cross-origin requests

## Dependencies

**Production:**
- `express` - Web framework
- `@supabase/supabase-js` - Supabase client
- `cors` - CORS middleware
- `dotenv` - Environment variable loading

**Development:**
- `nodemon` - Development server with hot reload

## Legacy Note

The `build/` directory contains Kotlin/Ktor artifacts from a previous implementation and can be safely ignored.
