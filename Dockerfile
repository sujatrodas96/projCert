FROM devopsedu/webapp:latest

# Remove default Apache index.html
RUN rm -f /var/www/html/index.html

# Copy your application files
COPY . /var/www/html/

# Set permissions
RUN chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]