local M = {}

-- Helper function to write to a file
local function write_file(path, content)
	local file = io.open(path, "w")
	if file then
		file:write(content)
		file:close()
	else
		print("Failed to write to file: " .. path)
	end
end

-- Command to create a Maven project
function M.create_maven_project()
	local project_name = vim.fn.input("Enter Maven project name: ")
	if project_name == "" then
		print("Project name cannot be empty.")
		return
	end

	local group_id = vim.fn.input("Enter groupId (default: com.mycompany): ", "com.mycompany")
	local artifact_id = project_name:gsub(" ", "-"):lower()
	local version = "1.0-SNAPSHOT"
	local project_dir = vim.fn.expand("%:p:h") .. "/" .. project_name

	-- Run Maven archetype command
	local cmd = string.format(
		"mvn archetype:generate -DgroupId=%s -DartifactId=%s -Dversion=%s -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false -DoutputDirectory=%s",
		group_id,
		artifact_id,
		version,
		project_dir
	)
	os.execute(cmd)

	-- Add default plugins to the POM file
	local pom_path = project_dir .. "/" .. artifact_id .. "/pom.xml"
	local pom_content = [[
<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <!-- Basic Project Information -->
  <groupId>]] .. group_id .. [[</groupId>
  <artifactId>]] .. artifact_id .. [[</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>jar</packaging>
  <name>]] .. project_name .. [[</name>
  <url>http://maven.apache.org</url>

  <!-- Dependencies -->
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.13.2</version> <!-- Updated JUnit version -->
      <scope>test</scope>
    </dependency>
  </dependencies>

  <!-- Build Configuration -->
  <build>
    <plugins>
      <!-- Compiler Plugin to Set Java Version -->
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.10.1</version> <!-- Latest version -->
        <configuration>
          <source>17</source> <!-- Specify Java source version -->
          <target>17</target> <!-- Specify Java target version -->
          <encoding>UTF-8</encoding>
        </configuration>
      </plugin>

      <!-- Jar Plugin for Creating Executable Jars -->
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-jar-plugin</artifactId>
        <version>3.3.0</version> <!-- Latest version -->
        <configuration>
          <archive>
            <manifest>
              <mainClass>]] .. group_id .. [[.App</mainClass> <!-- Replace with your main class -->
            </manifest>
          </archive>
        </configuration>
      </plugin>

      <!-- Exec Plugin for Running the Project -->
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>exec-maven-plugin</artifactId>
        <version>3.1.0</version>
        <configuration>
          <mainClass>]] .. group_id .. [[.App</mainClass> <!-- Replace with your main class -->
        </configuration>
      </plugin>

      <!-- Add this to enforce file encoding -->
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-resources-plugin</artifactId>
        <version>3.3.1</version> <!-- Latest version -->
        <configuration>
          <encoding>UTF-8</encoding> <!-- Set encoding explicitly -->
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
]]

	write_file(pom_path, pom_content)

	print("Maven project created successfully in: " .. project_dir)
end

-- Command to run the Maven project
function M.run_maven_project()
	-- Get the current working directory (pwd)
	local current_dir = vim.fn.system("pwd"):gsub("\n", "")  -- Remove the newline character from the output of pwd
	local cmd = "cd " .. current_dir .. " && mvn -X exec:java"

	-- Use tmux to run the command in a split window
	vim.fn.system(
		string.format(
			"tmux split-window -v 'bash -ic \"%s; echo; echo Code execution finished. Press any key to exit.; read -n 1\"'",
			cmd
		)
	)
end

-- Define custom commands
vim.api.nvim_create_user_command("CreateMavenProject", M.create_maven_project, { desc = "Create a Maven project" })
vim.api.nvim_create_user_command("RunMavenProject", M.run_maven_project, { desc = "Run the current Maven project" })

return M
