FROM devopsedu/webapp:latest

# Copy your application files
COPY . /var/www/html/

# Set permissions
RUN chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Use the correct startup command for this base image
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]