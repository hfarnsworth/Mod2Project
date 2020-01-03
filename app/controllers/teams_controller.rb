class TeamsController < ApplicationController
    before_action :authorize!, only: [:new, :create, :edit, :update, :destroy]
    before_action :team_get!, only: [:edit, :update, :show, :destroy]

    def index
        @teams = Team.all
    end

    def show
    end

    def new
        @team = Team.new
        @superheros = Superhero.all
    end

    def create
        team = Team.new(team_params)
        if team.valid?
            team.save
            redirect_to team
        else
            flash[:message] = team.errors.full_messages
            redirect_to new_team_path
        end
    end

    def edit
        @superheros = Superhero.all
    end

    def update
        team = @team.update(params.require(:team).permit(:name, superhero_ids:[]))
        if team.valid?
            redirect_to team_path(@team)
        else
            flash[:message] = team.errors.full_messages
            redirect_to edit_team_path(@team)
        end
    end

    def destroy
        @team.destroy
        redirect_to teams_path
    end

    private
    
    def team_params
        params.require(:team).permit(:name, superhero_ids:[])
    end

    def team_get!
        @team = Team.find_by(id: params[:id])
    end

end