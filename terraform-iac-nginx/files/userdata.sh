#!/bin/bash

# Retrieve instance metadata
HOSTNAME=$(hostname)
AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Generate HTML content with instance metadata
cat > index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terraform In Action</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 36px;
            margin-bottom: 20px;
            text-align: center;
        }
        .info {
            margin-bottom: 10px;
        }
        .info span {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Terraform In Action</h1>
        <div class="info">
            <span>Instance ID:</span> ${HOSTNAME}
        </div>
        <div class="info">
            <span>Host:</span> ${HOSTNAME}
        </div>
        <div class="info">
            <span>Availability Zone:</span> ${AVAILABILITY_ZONE}
        </div>
    </div>
</body>
</html>
EOF

# Copy the generated HTML file to the document root directory
sudo cp index.html /var/www/html/index.html
