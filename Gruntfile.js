'use strict';
var LIVERELOAD_PORT = 35729;
var SERVER_PORT = 9000;

module.exports = function (grunt) {

  // show elapsed time at the end
  require('time-grunt')(grunt);

  // Automatically load required Grunt tasks
  require('jit-grunt')(grunt, {
    useminPrepare: 'grunt-usemin',
    express: 'grunt-express-server'
  });

  // configurable paths
  var yeomanConfig = {
    app: 'app',
    dist: 'dist'
  };

  grunt.initConfig({
    yeoman: yeomanConfig,
    watch: {
      options: {
        nospawn: true,
        livereload: LIVERELOAD_PORT
      },
      coffee: {
        files: ['<%= yeoman.app %>/scripts/{,*/}*.coffee'],
        tasks: ['coffee:dist']
      },
      sass: {
        files: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}'],
        tasks: ['sass:server']
      },
      livereload: {
        options: {
          livereload: grunt.option('livereloadport') || LIVERELOAD_PORT
        },
        files: [
          '<%= yeoman.app %>/*.html',
          '{.tmp,<%= yeoman.app %>}/styles/{,*/}*.css',
          '{.tmp,<%= yeoman.app %>}/scripts/{,*/}*.js',
          '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}',
          '<%= yeoman.app %>/scripts/templates/*.{ejs,mustache,hbs}'
        ]
      },
      handlebars: {
        files: [
          '<%= yeoman.app %>/scripts/templates/{,*/}*.hbs'
        ],
        tasks: ['handlebars']
      },
      express: {
        files: [
          'server/**/*.coffee'
        ],
        tasks: ['express:livereload']
      }
    },
    express: {
      options: {
        port: grunt.option('port') || SERVER_PORT,
        opts: ['node_modules/coffee-script/bin/coffee']
      },
      livereload: {
        options: {
          node_env: 'livereload',
          script: 'server/main.coffee'
        }
      },
      dist: {
        options: {
          script: 'server/main.coffee'
        }
      }
    },
    open: {
      server: {
        path: 'http://localhost:<%= express.options.port %>'
      }
    },
    clean: {
      dist: ['.tmp', '<%= yeoman.dist %>/*'],
      server: '.tmp'
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      all: [
        'Gruntfile.js',
        '<%= yeoman.app %>/scripts/{,*/}*.js',
        '!<%= yeoman.app %>/scripts/vendor/*'
      ]
    },
    coffee: {
      dist: {
        files: [{
          // rather than compiling multiple files here you should
          // require them into your main .coffee file
          expand: true,
          cwd: '<%= yeoman.app %>/scripts',
          src: '{,*/}*.coffee',
          dest: '.tmp/scripts',
          ext: '.js'
        }]
      }
    },
    sass: {
      options: {
        sourceMap: true,
        includePaths: ['app/bower_components']
      },
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/styles',
          src: ['*.{scss,sass}'],
          dest: '.tmp/styles',
          ext: '.css'
        }]
      },
      server: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/styles',
          src: ['*.{scss,sass}'],
          dest: '.tmp/styles',
          ext: '.css'
        }]
      }
    },
    requirejs: {
      dist: {
        // Options: https://github.com/jrburke/r.js/blob/master/build/example.build.js
        options: {
          almond: true,

          replaceRequireScript: [{
            files: ['<%= yeoman.dist %>/index.html'],
            module: 'main'
          }],

          modules: [{name: 'main'}],
          baseUrl: '<%= yeoman.app %>/scripts',

          paths: {
            'main': '../../.tmp/scripts/main'
          },
          allowSourceOverwrites: true,
          mainConfigFile: '.tmp/scripts/main.js', // contains path specifications and nothing else important with respect to config

          keepBuildDir: true,
          dir: '.tmp/scripts',

          optimize: 'none', // optimize by uglify task
          useStrict: true,
          wrap: true

        }
      }
    },
    uglify: {
      dist: {
        files: {
          '<%= yeoman.dist %>/scripts/main.js': [
            '.tmp/scripts/main.js'
          ]
        }
      }
    },
    useminPrepare: {
      html: '<%= yeoman.app %>/index.html',
      options: {
        dest: '<%= yeoman.dist %>'
      }
    },
    usemin: {
      html: ['<%= yeoman.dist %>/{,*/}*.html'],
      css: ['<%= yeoman.dist %>/styles/{,*/}*.css'],
      options: {
        dirs: ['<%= yeoman.dist %>']
      }
    },
    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/images',
          src: '{,*/}*.{png,jpg,jpeg}',
          dest: '<%= yeoman.dist %>/images'
        }]
      }
    },
    cssmin: {
      dist: {
        files: {
          '<%= yeoman.dist %>/styles/main.css': [
            '.tmp/styles/{,*/}*.css',
            '<%= yeoman.app %>/styles/{,*/}*.css'
          ]
        }
      }
    },
    htmlmin: {
      dist: {
        options: {
          /*removeCommentsFromCDATA: true,
          // https://github.com/yeoman/grunt-usemin/issues/44
          //collapseWhitespace: true,
          collapseBooleanAttributes: true,
          removeAttributeQuotes: true,
          removeRedundantAttributes: true,
          useShortDoctype: true,
          removeEmptyAttributes: true,
          removeOptionalTags: true*/
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>',
          src: '*.html',
          dest: '<%= yeoman.dist %>'
        }]
      }
    },
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>',
          dest: '<%= yeoman.dist %>',
          src: [
            '*.{ico,txt}',
            'images/{,*/}*.{webp,gif}',
            'styles/fonts/{,*/}*.*',
            'bower_components/bootstrap-sass-official/assets/fonts/bootstrap/*.*'
          ]
        }, {
          src: 'node_modules/apache-server-configs/dist/.htaccess',
          dest: '<%= yeoman.dist %>/.htaccess'
        }]
      }
    },
    bower: {
      all: {
        rjsConfig: '<%= yeoman.app %>/scripts/main.js'
      }
    },
    handlebars: {
      compile: {
        options: {
          amd: true,
          namespace: function(filename) {
            filename = filename.split('templates/')[1];
            var names = filename.replace(/(.*)(\/\w+\.hbs)/, '$1');
            names = names.split('.hbs')[0];
            return 'JST.' + names.split('/').join('.');
          },
          processName: function(filepath) {
            return 'hbs'
          }
        },
        src: ["<%= yeoman.app %>/scripts/templates/**/*.hbs"],
        dest: ".tmp/scripts/templates.js"
      }
    },
    rev: {
      dist: {
        files: {
          src: [
            '<%= yeoman.dist %>/scripts/{,*/}*.js',
            '<%= yeoman.dist %>/styles/{,*/}*.css',
            '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}',
            '<%= yeoman.dist %>/styles/fonts/{,*/}*.*',
            'bower_components/bootstrap-sass-official/assets/fonts/bootstrap/*.*'
          ]
        }
      }
    }
  });

  grunt.registerTask('server', function (target) {
    grunt.log.warn('The `server` task has been deprecated. Use `grunt serve` to start a server.');
    grunt.task.run(['serve' + (target ? ':' + target : '')]);
  });

  grunt.registerTask('serve', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'open:server', 'express:dist']);
    }

    grunt.task.run([
      'clean:server',
      'coffee:dist',
      'handlebars',
      'sass:server',
      'express:livereload',
      'open:server',
      'watch'
    ]);
  });

  grunt.registerTask('build', [
    'clean:dist',
    'coffee',
    'handlebars',
    'sass:dist',
    'useminPrepare',
    'imagemin',
    'htmlmin',
    'concat',
    'cssmin',
    'requirejs',
    'uglify',
    'copy',
    'rev',
    'usemin'
  ]);

  grunt.registerTask('default', [
    'jshint',
    'build'
  ]);
};
