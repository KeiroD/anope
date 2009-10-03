/* ChanServ core functions
 *
 * (C) 2003-2009 Anope Team
 * Contact us at team@anope.org
 *
 * Please read COPYING and README for further details.
 *
 * Based on the original code of Epona by Lara.
 * Based on the original code of Services by Andy Church.
 *
 * $Id$
 *
 */
/*************************************************************************/

#include "module.h"

class CommandCSForbid : public Command
{
 public:
	CommandCSForbid() : Command("FORBID", 1, 2, "chanserv/forbid")
	{
	}

	CommandReturn Execute(User *u, std::vector<ci::string> &params)
	{
		ChannelInfo *ci;
		const char *chan = params[0].c_str();
		const char *reason = params.size() > 1 ? params[1].c_str() : NULL;

		Channel *c;
		Entry *cur, *enext;

		if (ForceForbidReason && !reason)
		{
			syntax_error(s_ChanServ, u, "FORBID", CHAN_FORBID_SYNTAX_REASON);
			return MOD_CONT;
		}

		if (*chan != '#')
		{
			notice_lang(s_ChanServ, u, CHAN_SYMBOL_REQUIRED);
			return MOD_CONT;
		}

		if (!ircdproto->IsChannelValid(chan))
		{
			notice_lang(s_ChanServ, u, CHAN_X_INVALID, chan);
			return MOD_CONT;
		}

		if (readonly)
		{
			notice_lang(s_ChanServ, u, READ_ONLY_MODE);
			return MOD_CONT;
		}

		if ((ci = cs_findchan(chan)) != NULL)
			delchan(ci);

		ci = makechan(chan);
		if (!ci)
		{
			alog("%s: Valid FORBID for %s by %s failed", s_ChanServ, ci->name, u->nick);
			notice_lang(s_ChanServ, u, CHAN_FORBID_FAILED, chan);
			return MOD_CONT;
		}

		ci->flags |= CI_FORBIDDEN;
		ci->forbidby = sstrdup(u->nick);
		if (reason)
			ci->forbidreason = sstrdup(reason);

		if ((c = findchan(ci->name)))
		{
			struct c_userlist *cu, *nextu;
			const char *av[3];

			/* Before banning everyone, it might be prudent to clear +e and +I lists.. 
			 * to prevent ppl from rejoining.. ~ Viper */
			if (ircd->except && c->excepts && c->excepts->count) {
				for (cur = c->excepts->entries; cur; cur = enext) {
					enext = cur->next;
					av[0] = "-e";
					av[1] = cur->mask;
					ircdproto->SendMode(whosends(ci), chan, "-e %s", cur->mask);
					chan_set_modes(whosends(ci)->nick, c, 2, av, 0);
				}
			}
			if (ircd->invitemode && c->invites && c->invites->count) {
				for (cur = c->invites->entries; cur; cur = enext) {
					enext = cur->next;
					av[0] = "-I";
					av[1] = cur->mask;
					ircdproto->SendMode(whosends(ci), chan, "-I %s", cur->mask);
					chan_set_modes(whosends(ci)->nick, c, 2, av, 0);
				}
			}

			for (cu = c->users; cu; cu = nextu)
			{
				nextu = cu->next;

				if (is_oper(cu->user))
					continue;

				av[0] = c->name;
				av[1] = cu->user->nick;
				av[2] = reason ? reason : getstring(cu->user->nc, CHAN_FORBID_REASON);
				ircdproto->SendKick(findbot(s_ChanServ), av[0], av[1], av[2]);
				do_kick(s_ChanServ, 3, av);
			}
		}

		if (WallForbid)
			ircdproto->SendGlobops(s_ChanServ, "\2%s\2 used FORBID on channel \2%s\2", u->nick, ci->name);

		if (ircd->chansqline)
		{
			ircdproto->SendSQLine(ci->name, ((reason) ? reason : "Forbidden"));
		}

		alog("%s: %s set FORBID for channel %s", s_ChanServ, u->nick, ci->name);
		notice_lang(s_ChanServ, u, CHAN_FORBID_SUCCEEDED, chan);

		FOREACH_MOD(I_OnChanForbidden, OnChanForbidden(ci));

		return MOD_CONT;
	}

	bool OnHelp(User *u, const ci::string &subcommand)
	{
		notice_help(s_ChanServ, u, CHAN_SERVADMIN_HELP_FORBID);
		return true;
	}

	void OnSyntaxError(User *u)
	{
		syntax_error(s_ChanServ, u, "FORBID", CHAN_FORBID_SYNTAX);
	}
};

class CSForbid : public Module
{
 public:
	CSForbid(const std::string &modname, const std::string &creator) : Module(modname, creator)
	{
		this->SetAuthor("Anope");
		this->SetVersion("$Id$");
		this->SetType(CORE);
		this->AddCommand(CHANSERV, new CommandCSForbid());
	}
	void ChanServHelp(User *u)
	{
		notice_lang(s_ChanServ, u, CHAN_HELP_CMD_FORBID);
	}
};

MODULE_INIT(CSForbid)
