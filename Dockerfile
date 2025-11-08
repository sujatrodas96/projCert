FROM devopsedu/webapp:latest

# Copy PHP application files
COPY . /var/www/html/

# Set permissions
RUN chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]