class MissionsController < ApplicationController
    before_action :authorize!, only: [:new, :create, :edit, :update, :destroy]
    before_action :mission_get!, only: [:show, :edit, :update, :destroy]

    def index
        @missions = Mission.all
    end

    def show
    end

    def new
        @mission = Mission.new
        @teams = Team.all
    end

    def create
        mission = Mission.new(mission_params)
        if mission.valid?
            mission.save
            # p op = Operation.create(mission: mission, team: team)
            redirect_to mission
        else
            flash[:message] = mission.errors.full_messages
            redirect_to new_mission_path
        end
    end

    def edit
        @teams = Team.all
    end

    def update
        mission = @mission.update(params.require(:mission).permit(:name, :nemesis, :description, team_ids:[]))
        if mission.valid?
            redirect_to mission_path(@mission)
        else
            flash[:message] = mission.errors.full_messages
            redirect_to edit_mission_path(@mission)
        end
    end

    def destroy
        @mission.destroy
        redirect_to missions_path
    end

    private

    def mission_params
        params.require(:mission).permit(:name, :nemesis, :description, team_ids:[])
    end

    def mission_get!
        @mission = Mission.find_by(id: params[:id])
    end
end