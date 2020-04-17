FROM nginx


# working directory


ORKDIR /usr/share/nginx/html


# Copy source code to working directory


COPY  ASBlog  /usr/share/nginx/html


#hadolint ignore=DL3013


# Expose port 80


EXPOSE 80
